import Ember from 'ember';

export default Ember.Controller.extend({
  chartOptions: {
    donut: false,
  },
  chartData: Ember.computed('model', 'totalPopulation', function() {
    let total = this.get('totalPopulation');

    let labels = [];
    let series = [];
    let worlds = this.get('model').worlds.slice().sort(function(a, b) {
      return b.population - a.population;
    });
    for (var world of worlds) {
      let percent = (world.population / total) * 100;
      let label = world.name + " " + percent.toFixed(2) + "%";
      labels.push(world.population > total * 0.01 ? label : '');
      series.push(world.population);
    }

    return {
      labels: labels,
      series: series,
    };
  }),
  totalPopulation: Ember.computed('model', function() {
    let count = 0;
    for (var world of this.get('model').worlds) {
      count += world.population;
    }
    return count;
  }),
  populationPercent: function(num) {
    return num / this.get('totalPopulation');
  }
});
