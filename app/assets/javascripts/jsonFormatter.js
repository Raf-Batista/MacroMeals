class JSONFormatter {

  static parseJSON(data){
    const userRecipes = [];
    for(let i = 0; i < data.length; i++){
      userRecipes.push({"id": data[i].id, "user": data[i].user.username, "recipeName": data[i].name, "macros": `Protien: ${data[i].protien}g Carbs: ${data[i].carbs}g Fat: ${data[i].fat}g`})
    }
    return userRecipes;
  }
}
