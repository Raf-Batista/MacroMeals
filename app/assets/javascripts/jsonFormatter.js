class JSONFormatter {

  static parseJSON(data){
    let userRecipes = [];
    for(let i = 0; i < data.length; i++){
      let recipe = data[i];
      userRecipes.push({"id": recipe.id, "data": `<li><a href="/recipes/${recipe.id}">${recipe.name}</a> ${recipe.macros}</li>`})

    }
    return userRecipes;
  }
}
