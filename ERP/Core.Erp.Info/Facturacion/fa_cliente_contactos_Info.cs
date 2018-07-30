using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
   public class fa_cliente_contactos_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCliente { get; set; }
        public int IdContacto { get; set; }
        [Required(ErrorMessage = ("El campo nombres es obligatorio"))]
        public string Nombres { get; set; }
        public string Telefono { get; set; }
        public string Celular { get; set; }
        public string Correo { get; set; }
        public string Direccion { get; set; }
        [Required(ErrorMessage = ("El campo ciudad es obligatorio"))]
        public string IdCiudad { get; set; }
        [Required(ErrorMessage = ("El campo parroquia es obligatorio"))]
        public string IdParroquia { get; set; }
        public string Direccion_emp { get; set; }
    }
}
