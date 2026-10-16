import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/api_client.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../data/data_source/product_details_remote_data_source_impl.dart';
import '../data/repository/product_details_repository_impl.dart';
import '../domain/entities/product_details_entity.dart';
import '../domain/use_cases/get_product_details.dart';
import '../presentation/view_model/product_details_cubit.dart';
import '../presentation/view_model/product_details_states.dart';
import '../widgets/color_selector.dart';
import '../widgets/size_selector.dart';
import '../widgets/share_product_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final apiClient = ApiClient();
    final dataSource = ProductDetailsRemoteDataSourceImpl(apiClient);
    final repository = ProductDetailsRepositoryImpl(dataSource);

    return BlocProvider(
      create: (_) =>
          ProductDetailsCubit(getProductDetails: GetProductDetails(repository))
            ..loadProductDetails(productId: productId),
      child: _ProductDetailsView(productId: productId),
    );
  }
}

class _ProductDetailsView extends StatefulWidget {
  final int productId;

  const _ProductDetailsView({required this.productId});

  @override
  State<_ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<_ProductDetailsView> {
  Color _selectedColor = Colors.white;
  String _selectedSize = 'M';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading ||
              state is ProductDetailsInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailsError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context
                  .read<ProductDetailsCubit>()
                  .loadProductDetails(productId: widget.productId),
            );
          }

          if (state is ProductDetailsSuccess) {
            return _DetailsContent(
              product: state.product,
              selectedColor: _selectedColor,
              selectedSize: _selectedSize,
              onColorSelected: (color) =>
                  setState(() => _selectedColor = color),
              onSizeSelected: (size) => setState(() => _selectedSize = size),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _DetailsContent extends StatelessWidget {
  final ProductDetailsEntity product;
  final Color selectedColor;
  final String selectedSize;
  final ValueChanged<Color> onColorSelected;
  final ValueChanged<String> onSizeSelected;

  const _DetailsContent({
    required this.product,
    required this.selectedColor,
    required this.selectedSize,
    required this.onColorSelected,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = _getImageUrl(product.images, product.id);
    const colors = [Colors.white, Colors.black, Colors.grey];
    const sizes = ['S', 'M', 'L', 'XL'];

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          backgroundColor: AppTheme.background,
          leading: IconButton(
            icon: const _CircleIcon(icon: Icons.arrow_back_ios_new, size: 16),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            ShareProductButton(productId: product.id ?? 0),
            IconButton(
              icon: const _CircleIcon(icon: Icons.favorite_border, size: 18),
              onPressed: () {},
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Hero(
              tag: 'product-${product.id}',
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            transform: Matrix4.translationValues(0, -32, 0),
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.title ?? 'Untitled product',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(fontSize: 28, height: 1.2),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '\$${(product.price ?? 0).toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(color: AppTheme.primary, fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Description'),
                const SizedBox(height: 8),
                Text(
                  product.description ?? 'No description available.',
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(height: 1.6, fontSize: 16),
                ),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Select Color'),
                const SizedBox(height: 12),
                ColorSelector(
                  colors: colors,
                  selectedColor: selectedColor,
                  onColorSelected: onColorSelected,
                ),
                const SizedBox(height: 24),
                const _SectionTitle(title: 'Select Size'),
                const SizedBox(height: 12),
                SizeSelector(
                  sizes: sizes,
                  selectedSize: selectedSize,
                  onSizeSelected: onSizeSelected,
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: 'Add to Cart',
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.title ?? 'Product'} added to cart',
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final double size;

  const _CircleIcon({required this.icon, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: size),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

String _getImageUrl(List<String>? images, int? productId) {
  final imageUrl = images
      ?.map((image) => image.replaceAll(r'\"', '').replaceAll('"', '').trim())
      .firstWhere((image) {
        final uri = Uri.tryParse(image);
        return uri != null &&
            (uri.scheme == 'http' || uri.scheme == 'https') &&
            uri.host.isNotEmpty;
      }, orElse: () => '');

  if (imageUrl != null && imageUrl.isNotEmpty) return imageUrl;
  return 'https://picsum.photos/seed/${productId ?? 'product'}/600/600';
}
