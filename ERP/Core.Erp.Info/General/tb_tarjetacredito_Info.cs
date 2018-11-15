using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.General
{
    public class tb_TarjetaCredito_Info
    {
        [Key]
        public int IdTarjeta { get; set; }
        [Required(ErrorMessage = "El campo descripción es obligatorio")]

        public string NombreTarjeta { get; set; }
        [StringLength(500, MinimumLength = 1, ErrorMessage = "El campo nombre de tarjeta debe tener mínimo 1 caracter y máximo 500")]

        public bool Estado { get; set; }
    }
}
