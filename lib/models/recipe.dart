class Recipe {
  String recipeName;
  String imageURL;
  int recipeCode;
  String description;
  List<String> ingredients = [];
  List<String> recipe = [];
  int scrapped = 0;
  Recipe(this.recipeName, this.imageURL, this.recipeCode, this.description,
      this.ingredients, this.recipe) {}
}
