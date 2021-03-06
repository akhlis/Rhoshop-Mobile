final productSearchSuggestions = """
      query(\$filter: FilterProductsInput, \$language: String) {
        products(filter: \$filter, language: \$language ) {
          id
          name
          image
        }
      }
      """;

final productsByCategory = """
      query(\$filter: FilterProductsInput, \$language: String) {
        products(filter: \$filter, language: \$language ) {
          id
          name
          image
          price
        }
      }
      """;

final productsForCart = """
      query(\$filter: FilterProductsInput, \$language: String) {
        products(filter: \$filter, language: \$language ) {
          id
          name
          image
          price
        }
      }
      """;
