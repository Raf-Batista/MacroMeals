class JSONFormatter {

  static getJSON(url){
    $.get(url, (data) => {
      console.log(data)
    })
  }
}

// Recipe Name protien carbs fat cooktime 
