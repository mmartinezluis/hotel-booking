class City {
  static all = [];
  static datalist = document.getElementById("city_name");
  // constructor({ code, name }) {
  //   this.code = code;
  //   this.name = name;
  //   this.option = document.createElement("option");
  //   this.option.value = `${this.name} (${this.code})`;
  // }
  constructor(data) {
    this.name = data[0];
    this.code = data[1];
    this.option = document.createElement("option");
    this.option.value = `${this.name} (${this.code})`;
  }

  static getCities() {
    fetch(`http://localhost:3000/datalist`)
      .then((resp) => resp.json())
      .then((cities) => {
        for (const city of cities) {
          console.log(city);
          const c = new City(city);
          c.addToDatalist();
        }
      });
  }

  addToDatalist() {
    City.datalist.appendChild(this.option);
  }
}

City.getCities();
