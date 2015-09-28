import Ember from 'ember';

export default Ember.Controller.extend({
  chartOptions: {
    donut: true,
  },
  chartData: Ember.computed('model', 'totalPopulation', function() {
    let total = this.get('totalPopulation');

    let labels = [];
    let series = [];
    for (var world of this.get('model').worlds) {
      labels.push(world.population > total * 0.01 ? world.name : '');
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
