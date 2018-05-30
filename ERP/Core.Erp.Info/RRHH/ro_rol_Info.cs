using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.RRHH;
using System.ComponentModel.DataAnnotations;

namespace Core.Erp.Info.RRHH
{
   public class ro_rol_Info
    {
        public int IdEmpresa { get; set; }
        [Required(ErrorMessage = "El campo nómina es obligatorio")]
        public int IdNomina_Tipo { get; set; }
        [Required(ErrorMessage = "El campo tipo de nómina es obligatorio")]
        public int IdNomina_TipoLiqui { get; set; }
        [Required(ErrorMessage = "El campo périodo es obligatorio")]
        public int IdPeriodo { get; set; }
        [Required(ErrorMessage = "El campo descripción es obligatorio")]
        public string Descripcion { get; set; }
        [Required(ErrorMessage = "El campo observación es obligatorio")]
        public string Observacion { get; set; }
        public string Cerrado { get; set; }
        public System.DateTime FechaIngresa { get; set; }
        public string UsuarioIngresa { get; set; }
        public Nullable<System.DateTime> FechaModifica { get; set; }
        public string UsuarioModifica { get; set; }
        public Nullable<System.DateTime> FechaAnula { get; set; }
        public string UsuarioAnula { get; set; }
        public string MotivoAnula { get; set; }
        public string UsuarioCierre { get; set; }
        public Nullable<System.DateTime> FechaCierre { get; set; }
        public string IdCentroCosto { get; set; }

    }
}
