import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  test(){
    const elementHtml =  this.element;
    console.log(elementHtml)
  }
}
