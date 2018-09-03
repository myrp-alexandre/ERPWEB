using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Compras
{
    public class com_ordencompra_local_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public decimal IdOrdenCompra { get; set; }
        public decimal IdProveedor { get; set; }
        public string oc_NumDocumento { get; set; }
        public string Tipo { get; set; }
        public string IdTerminoPago { get; set; }
        public int oc_plazo { get; set; }
        public System.DateTime oc_fecha { get; set; }
        public double oc_flete { get; set; }
        public string oc_observacion { get; set; }
        public string Estado { get; set; }
        public string IdEstadoAprobacion_cat { get; set; }
        public Nullable<System.DateTime> co_fecha_aprobacion { get; set; }
        public string IdUsuario_Aprueba { get; set; }
        public string IdUsuario_Reprue { get; set; }
        public Nullable<System.DateTime> co_fechaReproba { get; set; }
        public Nullable<System.DateTime> Fecha_Transac { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltMod { get; set; }
        public Nullable<System.DateTime> FechaHoraAnul { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public string IdEstadoRecepcion_cat { get; set; }
        public string AfectaCosto { get; set; }
        public string MotivoAnulacion { get; set; }
        public string MotivoReprobacion { get; set; }
        public string Solicitante { get; set; }
        public Nullable<decimal> IdSolicitante { get; set; }
        public Nullable<decimal> IdDepartamento { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<int> IdMotivo { get; set; }
        public Nullable<System.DateTime> oc_fechaVencimiento { get; set; }
        public string IdEstado_cierre { get; set; }
        public decimal IdComprador { get; set; }
    }
}
