using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorCobrar
{
    public class cxc_liquidacion_comisiones_Info
    {
        public decimal IdTransaccionSession { get; set; }
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        [Required(ErrorMessage = "El campo fecha  es obligatorio")]
        public System.DateTime Fecha { get; set; }
        public string Observacion { get; set; }
        public Nullable<int> IdVendedor { get; set; }
        public bool Estado { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> FechaTransac { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaUltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> FechaUltAnu { get; set; }
        public string MotivoAnulacion { get; set; }

        // campos que no existen en la tabla
        public List<cxc_liquidacion_comisiones_det_Info> lst_det { get; set; }

    }
}
