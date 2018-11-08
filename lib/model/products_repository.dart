// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product> [
      Product(
        category: Category.accessories,
        id: 0,
        isFeatured: true,
        name: 'Hotel Maria Cristina',
        location: 'San Sebastian, Spain',
        rating: 3,
      ),
      Product(
        category: Category.accessories,
        id: 1,
        isFeatured: true,
        name: 'Four Seasons Resort',
        location: 'Chiang Mai, Thailand',
        rating: 3,
      ),
      Product(
        category: Category.accessories,
        id: 2,
        isFeatured: false,
        name: 'Belmond Grand Hotel Timeo',
        location: 'Taormina, Italy',
        rating: 5,
      ),
      Product(
        category: Category.accessories,
        id: 3,
        isFeatured: true,
        name: 'Brewery Gulch Inn',
        location: 'Mendocino, California',
        rating: 3,
      ),
      Product(
        category: Category.accessories,
        id: 4,
        isFeatured: false,
        name: 'Inverlochy Castle Hotel',
        location: 'Torlundy, Scotland',
        rating: 4,
      ),
      Product(
        category: Category.accessories,
        id: 5,
        isFeatured: false,
        name: 'The Mulia',
        location: 'Bali, Indonesia',
        rating: 2,
      ),
      Product(
        category: Category.accessories,
        id: 6,
        isFeatured: false,
        name: 'Tierra Patagonia Hotel & Spa',
        location: 'Torres del Paine, Chile',
        rating: 5,
      ),
      Product(
        category: Category.accessories,
        id: 7,
        isFeatured: true,
        name: 'Temple House',
        location: 'Chengdu, China',
        rating: 5,
      ),
      Product(
        category: Category.accessories,
        id: 8,
        isFeatured: true,
        name: 'Nihi Sumba Island',
        location: 'Indonesia',
        rating: 4,
      ),
      Product(
        category: Category.home,
        id: 9,
        isFeatured: true,
        name: 'Nayara Springs',
        location: 'Arenal, Costa Rica',
        rating: 5,
      ),

    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
