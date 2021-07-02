class City {
  static all = []
  static datalist = document.getElementById('city_name')
  constructor({code}){
      // this.name = name
      this.code = code

      this.option = document.createElement('option')
      // debugger
      this.option.value = this.code
  }

  static getCities(){
    // debugger
    fetch(`http://localhost:3000/datalist`)
    .then(resp => resp.json())
    .then(cities => {
      for (const city of cities){
        const c = new City(city)
        c.addToDatalist();
      }
    })
  }

  addToDatalist(){
    City.datalist.appendChild(this.option)
  }
}

City.getCities()