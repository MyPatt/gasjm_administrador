//Clase con metodo de validaciones de campos
import 'package:cloud_firestore/cloud_firestore.dart';

class Validacion {
  //Metodo para validar cedula que no sea nulo y vacio

  static String? validarCedula(String? value) {
    if (value == null) {
      return null;
    }

    if (value.isEmpty) {
      return 'Ingrese un número de cédula';
    } else if (value.length < 10 || value.length > 10) {
      return 'El número de cédula debe tener 10 caracteres';
    }
    /*else if (esCedulaValida(value) == false) {
      return 'Ingrese un número de cédula válido';
    }*/
    return null;
  }
  //Metodo para validar que el nombre nu sea nulo y vacio

  static String? validarNombre(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese un nombre';
    } else if (value.length < 3 || value.length > 32) {
      return 'El nombre debe tener al menos 3 caracteres';
    }

    return null;
  }

  //Metodo para validar que el apellido nu sea nulo y vacio
  static String? validarApellido(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese un apellido';
    } else if (value.length < 3 || value.length > 32) {
      return 'El apellido debe tener al menos 3 caracteres';
    }

    return null;
  }
  //

  //Metodo para validar que el correo electronico nu sea nulo y vacio

  static String? validarCorreoElectronico(String? correoElectronico) {
    if (correoElectronico == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (correoElectronico.isEmpty) {
      return 'Ingrese un correo electrónico';
    } else if (!emailRegExp.hasMatch(correoElectronico)) {
      return 'Ingrese un correo electrónico válido';
    }

    return null;
  }

  static String? validarContrasena(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingresar una contraseña';
    } else if (value.length < 6 || value.length > 32) {
      return 'Debe tener al menos 6 caracteres';
    }

    return null;
  }

  static bool esCedulaValida(String cedula) {
    try {
      //LongitudCedula
      if (cedula.length == 10) {
        int tercerDigito = int.parse(cedula.substring(2, 3));
        if (tercerDigito < 6) {
// Coeficientes de validación cédula
// El decimo digito se lo considera dígito verificador
          List<int> coefValCedula = [2, 1, 2, 1, 2, 1, 2, 1, 2];
          int verificador = int.parse(cedula.substring(9, 10));
          int suma = 0;
          int digito = 0;
          for (int i = 0; i < (cedula.length - 1); i++) {
            digito = int.parse(cedula.substring(i, i + 1)) * coefValCedula[i];
            suma += ((digito % 10) + (digito / 10)) as int;
          }

          if ((suma % 10 == 0) && (suma % 10 == verificador)) {
            return true;
          } else if ((10 - (suma % 10)) == verificador) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  /* FORM PEDIR GAS */
//Metodo para validar que el nombre nu sea nulo y vacio

  static String? validarCantidadGas(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese una cantidad';
    }
    return null;
  }

  //Validar que la direccion sea valida
  static String? validarDireccion(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty || value == 'Buscando dirección...') {
      return 'Seleccione en el mapa una dirección';
    }
    return null;
  }

  //Metodo para validar el numero celular que tenga 10 digitos

  static String? validarCelular(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return null;
    }
    if (value.length < 10 || value.length > 10) {
      return 'El número celular debe tener 10 caracteres';
    }
    return null;
  }

  //VEHICULO

  //Metodo para validar placa 3 primeras caracteres 4 ultimos digitos

  static String? validarPlaca(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese una placa';
    } else if (value.length < 5) {
      return 'Ingrese una placa válida';
    } else {
      var aux1 = value.substring(0, 3).contains(RegExp(r'[0-9]'));
      var aux2 = value.substring(3, value.length).contains(RegExp(r'[a-zA-Z]'));
      /*print(value.substring(0, 3));
      print(value.substring(3, value.length));
      print(aux1);
      print(aux2);*/
      if (aux1 == true || aux2 == true) {
        return 'Ingrese una placa válida';
      }
    }
    return null;
  }

  static String? validarAnio(String? value) {
    if (value == null) {
      return null;
    }

    //Obtener anio actual
    int actual = Timestamp.now().toDate().year;

    if (value.isEmpty) {
      return 'Ingrese un año';
    } else if (int.parse(value) < 2000 || int.parse(value) > actual) {
      return 'El año debe estar entre 2000 y $actual';
    }

    return null;
  }

  //Metodo para validar que el nombre nu sea nulo y vacio

  static String? validarValor(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Ingrese un valor';
    } else if (value.length < 3 || value.length > 32) {
      return 'El valor debe tener al menos 3 caracteres';
    }

    return null;
  }
  /*PRODUCTO*/
    static String? validarPrecioProducto(String? value) {
    if (value == null) {
      return null;
    }
 
      if (value.isEmpty) {
      return 'Ingrese un valor';
    }  
    return null;
  }
  //
  static String? validarCelularObligatorio(String? value) {
    if (value == null) {
      return null;
    }
 
      if (value.isEmpty) {
      return 'Ingrese un valor';
    } else if (value.length < 10 || value.length > 10) {
      return 'El número celular debe tener 10 caracteres';
    }
    return null;
  }
  //verificar un numero double
}
