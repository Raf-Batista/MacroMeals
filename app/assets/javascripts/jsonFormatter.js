class JSONFormatter {

  static parseJSONIndex(data){
    let userRecipes = [];
    for(let i = 0; i < data.length; i++){
      let recipe = data[i];
      userRecipes.push({"id": recipe.id, "data": `<li><a href="/recipes/${recipe.id}.json">${recipe.name}</a> ${recipe.macros}</li>`})

    }
    return userRecipes;
  }

  static parseJSONShow(data){
    return `<li>${data.name} ${data.macros} ${data.ingredients} ${data.prep_time} ${data.cook_time} ${data.directions}</li>`
  }
}
