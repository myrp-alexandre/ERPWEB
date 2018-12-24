using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Compras
{
    public class com_Motivo_Orden_Compra_Info
    {
        public int IdEmpresa { get; set; }
        public int IdMotivo { get; set; }
        [StringLength(20, MinimumLength = 1, ErrorMessage = "el campo código debe tener mínimo 1 caracter y máximo 20")]
        public string Cod_Motivo { get; set; }
        [Required(ErrorMessage = ("el campo descripción es obligatorio"))]
        [StringLength(250, MinimumLength = 1, ErrorMessage = "el campo descripción debe tener mínimo 1 caracter y máximo 250")]
        public string Descripcion { get; set; }
        public string estado { get; set; }
        public bool EstadoBool { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaHoraAnul { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string MotivoAnulacion { get; set; }
    }
}
