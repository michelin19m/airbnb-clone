import { Controller } from "@hotwired/stimulus"
import {enter, leave} from "el-transition"

export default class extends Controller {

  connect() {
    document.getElementById('modal-wrapper').addEventListener('click', this.closeModal);
  }

  closeModal(event){
    const modalPanelClicked = document.getElementById('modal-panel').contains(event.target);
    if(!modalPanelClicked && event.target.id !== 'modal-trigger') {
      leave(document.getElementById('modal-wrapper'));
    }
  }

  showModal() {
    enter(document.getElementById('modal-wrapper'));
  }
}
