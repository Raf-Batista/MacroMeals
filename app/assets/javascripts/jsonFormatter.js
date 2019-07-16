class JSONFormatter {

  static getJSON(url){
    $.get(url, () => {
      alert(url)
    })
  }
}
