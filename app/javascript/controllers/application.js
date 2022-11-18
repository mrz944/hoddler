import { Application } from "@hotwired/stimulus"
import Alpine from "alpinejs"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Consigure Alpine.js
window.Alpine = Alpine
Alpine.start()

export { application }
