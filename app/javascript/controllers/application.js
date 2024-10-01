import { Application } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "popper.js"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
