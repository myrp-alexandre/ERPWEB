using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorPagar
{
    public class cp_SolicitudPago_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdSolicitud { get; set; }
        public int IdSucursal { get; set; }
        public System.DateTime Fecha { get; set; }
        public decimal IdProveedor { get; set; }
        public string Concepto { get; set; }
        public bool Estado { get; set; }
        public double Valor { get; set; }
        public string Solicitante { get; set; }
        public string IdUsuarioCreacion { get; set; }
        public Nullable<System.DateTime> FechaCreacion { get; set; }
        public string IdUsuarioModificacion { get; set; }
        public Nullable<System.DateTime> FechaModificacion { get; set; }
        public string IdUsuarioAnulacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
    }
}
