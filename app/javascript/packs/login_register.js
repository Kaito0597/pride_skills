import {MDCFloatingLabel} from '@material/floating-label';

const usernameFloatingLabel = new MDCFloatingLabel(document.querySelector('#username-label'));
const passwordFloatingLabel = new MDCFloatingLabel(document.querySelector('#password-label'));

$('#username-text-field').on('focus', function() {
    usernameFloatingLabel.float(true)
})
$('#username-text-field').on('focusout', function() {
    if ($(this).val() == "") {
        usernameFloatingLabel.float(false)
    }
})

$('#password-text-field').on('focus', function() {
    passwordFloatingLabel.float(true)
})
$('#password-text-field').on('focusout', function() {
    if ($(this).val() == "") {
        passwordFloatingLabel.float(false)
    }
})