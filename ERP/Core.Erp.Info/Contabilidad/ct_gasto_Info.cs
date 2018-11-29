using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Contabilidad
{
    public class ct_gasto_Info
    {
        public int IdGasto { get; set; }
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = "El campo descripción es obligatorio")]
        [StringLength(500, MinimumLength = 1, ErrorMessage = "El campo nombre de tarjeta debe tener mínimo 1 caracter y máximo 500")]

        public string Descripcion { get; set; }
        [Required(ErrorMessage = "El campo cuenta contable es obligatorio")]
        public string IdCtaCble { get; set; }        
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        [Required(ErrorMessage = "El campo motivo anulación es obligatorio")]
        [StringLength(500, MinimumLength = 1, ErrorMessage = "El campo motivo de anulación debe tener mínimo 1 caracter y máximo 500")]
        public string MotiAnu { get; set; }
    }
}
