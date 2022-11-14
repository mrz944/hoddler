# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js"
pin "lightweight-charts", to: "https://ga.jspm.io/npm:lightweight-charts@3.8.0/dist/lightweight-charts.esm.production.js"
pin "fancy-canvas/coordinate-space", to: "https://ga.jspm.io/npm:fancy-canvas@0.2.2/coordinate-space.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/components", under: "components"
