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
        [Required(ErrorMessage = "El campo nombre de tarjeta es obligatorio")]
        [StringLength(500, MinimumLength = 1, ErrorMessage = "El campo nombre de tarjeta debe tener mínimo 1 caracter y máximo 500")]

        public string NombreTarjeta { get; set; }
        
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
    }
}
