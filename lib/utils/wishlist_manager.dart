List<String> wishlist = [];

bool isInWishlist(String symbol) {
  return wishlist.contains(symbol);
}

void toggleWishlist(String symbol) {
  if (isInWishlist(symbol)) {
    wishlist.remove(symbol);
  } else {
    wishlist.add(symbol);
  }
}
