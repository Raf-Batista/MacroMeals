class JSONFormatter {

  static parseJSONIndex(data){
    let userRecipes = [];
    for(let i = 0; i < data.length; i++){
      const recipe = data[i];
      userRecipes.push({"id": recipe.id, "data": `<li><a href="/recipes/${recipe.id}.json">${recipe.name}</a> ${recipe.macros}</li>`})

    }
    return userRecipes;
  }

  static parseJSONShow(data){

    function getIngredients(recipe){
      let ingredients = '';
      const recipes = recipe.ingredients;
      for(let i = 0; i < recipes.length; i++){
        ingredients += `<p>${recipes[i].item.name}: ${recipes[i].quantity}</p> `
      }
      ingredients += '</ul>'
      return ingredients;
    }

     const ingredients = getIngredients(data);
    return `<p>${data.name}</p> ${ingredients} <p>${data.macros}</p> <p> Prep Time: ${data.prep_time}</p> <p>Cook Time: ${data.cook_time}</p> <p> Directions: ${data.directions}</p>`
  }

  static prepJSONPost(data){
    const arr = [];
    for(let i = 2; i < data.length; i++){
      arr.push(  data[i] )
    }
      return arr;
  }

  static parseJSONPost(data){
    return
  }

}
