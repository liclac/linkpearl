import Ember from 'ember';

export default Ember.Controller.extend({
  chartOptions: {
    donut: true,
  },
  chartData: Ember.computed('model', function() {
    let labels = [];
    let series = [];
    for (var company of this.get('model').grand_companies) {
      labels.push(company.alt);
      series.push({ data: company.members, className: "gc-" + company.id });
    }

    return {
      labels: labels,
      series: series,
    };
  }),
});
