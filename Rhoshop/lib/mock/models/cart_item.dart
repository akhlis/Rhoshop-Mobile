import 'package:flutter/material.dart';
import 'package:rhoshop/mock/models/product.dart';

class CartItem {
  Product product;
  ProductSize productSize;
  Color productColor;
  int count;

  CartItem(this.product, this.productSize, this.productColor, this.count);

  CartItem increment() {
    this.count++;
    return this;
  }

  CartItem decrement() {
    if (count > 1) {
      this.count--;
    }
    return this;
  }

  @override
  bool operator ==(other) {
    return other is CartItem &&
        this.product.id == other.product.id &&
        productColor == other.productColor &&
        this.productSize == other.productSize;
  }

  @override
  int get hashCode => this.product.id.hashCode;
}