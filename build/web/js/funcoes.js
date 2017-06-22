function validarSenha(input) {
    if (input.value !== document.getElementById("senha2").value) {
        input.setCustomValidity('Senhas diferentes');
        
    } else {
        input.setCustomValidity('');
    }
}


