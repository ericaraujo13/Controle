import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const divElement = this.element;
    const monthsData = JSON.parse(divElement.getAttribute('data-days-balance'));

    let months = [];
    let total = [];

    monthsData.forEach(element => {
      months.push(element[0])
      total.push(element[1])
    });

    const data = {
      labels: months,
      datasets: [{
        label: '',
        data: total,
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(255, 159, 64, 0.2)',
          'rgba(255, 205, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(153, 102, 255, 0.2)',
        ],
        borderColor: [
          'rgb(255, 99, 132)',
          'rgb(255, 159, 64)',
          'rgb(255, 205, 86)',
          'rgb(75, 192, 192)',
          'rgb(54, 162, 235)',
          'rgb(153, 102, 255)',
        ],
        borderWidth: 1
      }]
    };

    new Chart("balanceChart", {
      type: 'line',
      data: data,
      options: {
        plugins: {
          legend: {
              display: false,
              labels: {
                  color: 'rgb(255, 99, 132)'
              }
          }
      },
        scales: {
          y: {
            beginAtZero: true
          }
        }
      },
    });
  }
}
