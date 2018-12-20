using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
   public class ro_NominasPagosCheques_Info
    {
        public int IdEmpresa { get; set; }
        public int IdTransaccion { get; set; }
        public int IdNomina_Tipo { get; set; }
        public int IdNomina_TipoLiqui { get; set; }
        public int IdPeriodo { get; set; }
        public string Observacion { get; set; }
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public string IdUsuarioAnu { get; set; }
        public string MotivoAnu { get; set; }
        public string IdUsuarioUltModi { get; set; }
        public Nullable<System.DateTime> FechaAnu { get; set; }
        public System.DateTime FechaTransac { get; set; }
        public Nullable<System.DateTime> FechaUltModi { get; set; }

        public List<ro_NominasPagosCheques_det_Info> detalle { get; set; }

    }
}
