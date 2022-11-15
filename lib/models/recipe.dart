class Recipe {
  String recipeName;
  String imageURL;
  int recipeCode;
  String description;
  List<String> ingredients = [];
  List<String> recipe = [];

  Recipe(this.recipeName, this.imageURL, this.recipeCode, this.description,
      this.recipe) {}
}
