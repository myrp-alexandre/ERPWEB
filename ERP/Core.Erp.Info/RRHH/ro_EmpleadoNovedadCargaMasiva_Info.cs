using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.RRHH
{
  public  class ro_EmpleadoNovedadCargaMasiva_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdCarga { get; set; }
        public int IdNomina { get; set; }
        public int IdNominaTipo { get; set; }
        public int IdSucursal { get; set; }
        public System.DateTime FechaCarga { get; set; }
        public string Observacion { get; set; }
        public string IdRubro { get; set; }
        public string IdUsuario { get; set; }
        public bool Estado { get; set; }
        public System.DateTime Fecha_Transac { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotiAnula { get; set; }

        public List<ro_EmpleadoNovedadCargaMasiva_det_Info> detalle { get; set; }
    }
}
