// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

// Flowbite
import "flowbite"

// Charts
import "chartkick/highcharts"

// ActiveStorage
import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

// Trix / ActionText
import "trix"
import "@rails/actiontext"

// Stimulus
// import "./controllers"
import { Application } from "@hotwired/stimulus"
const application = Application.start();

import NotificationController from "./controllers/notification_controller"
application.register("notification", NotificationController)

import { Dropdown } from "tailwindcss-stimulus-components"
application.register('dropdown', Dropdown)

import TabNavigationComponentController from "../components/tab_navigation_component_controller"
application.register("tab-navigation-component", TabNavigationComponentController)
