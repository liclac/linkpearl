import Ember from 'ember';

export default Ember.Controller.extend({
  chartOptions: {
    donut: false,
  },
  chartData: Ember.computed('model', 'totalPopulation', function() {
    let total = this.get('totalPopulation');
    let labels = [];
    let series = [];
    for (var world of this.get('sortedWorlds')) {
      let label = world.name + " " + this.percent(world.population, total) + "%";
      labels.push(world.population > total * 0.01 ? label : '');
      series.push(world.population);
    }

    return {
      labels: labels,
      series: series,
    };
  }),
  tableData: Ember.computed('model', 'totalPopulation', function() {
    let total = this.get('totalPopulation');
    let data = [];
    for (var world of this.get('sortedWorlds')) {
      data.push({
        name: world.name,
        population: world.population,
        percent: this.percent(world.population, total),
      });
    }
    return data;
  }),
  totalPopulation: Ember.computed('model', function() {
    let count = 0;
    for (var world of this.get('model').worlds) {
      count += world.population;
    }
    return count;
  }),
  sortedWorlds: Ember.computed('model', function() {
    return this.get('model').worlds.slice().sort(function(a, b) {
      return b.population - a.population;
    });
  }),
  percent: function(part, whole) {
    return ((part / whole) * 100).toFixed(2);
  }
});
