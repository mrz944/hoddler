import Rails from "@rails/ujs";
import { createChart } from 'lightweight-charts';

const initCryptoChart = () => {
  const container = document.getElementById('crypto_chart');

  const chart = createChart(container, {
    width: 800,
    height: 600,
    timeScale: {
      timeVisible: true,
      borderColor: '#2a2e39',
      },
    rightPriceScale: {
      borderColor: '#2a2e39',
    },
    layout: {
      backgroundColor: '#2e2e2e',
      textColor: '#b2b5be',
    },
    grid: {
      vertLines: { color: 'rgba(240, 243, 250, 0.06)' },
      horzLines: { color: 'rgba(240, 243, 250, 0.06)' },
    }
  });

  const series = chart.addCandlestickSeries({
    upColor: '#b4d273',
    downColor: '#b05279',
    wickUpColor: '#b4d273',
    wickDownColor: '#b05279',
    borderVisible: false,
  });

  // # TODO: set current price based on data.stats.current_price.price
  Rails.ajax({
    url: window.location.pathname + '.json',
    type: "get",
    data: "",
    success: function(data) {
      series.setData(data.klines);
      series.setMarkers(data.markers);
    },
    error: function(data) {}
  })
}

export { initCryptoChart };
