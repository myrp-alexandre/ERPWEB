using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
    public class fa_factura_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public decimal IdCbteVta { get; set; }
        public string CodCbteVta { get; set; }
        public string vt_tipoDoc { get; set; }
        public string vt_serie1 { get; set; }
        public string vt_serie2 { get; set; }
        public string vt_NumFactura { get; set; }
        public Nullable<System.DateTime> Fecha_Autorizacion { get; set; }
        public string vt_autorizacion { get; set; }
        public decimal IdCliente { get; set; }
        public Nullable<int> IdContacto { get; set; }
        public int IdVendedor { get; set; }
        public System.DateTime vt_fecha { get; set; }
        public decimal vt_plazo { get; set; }
        public System.DateTime vt_fech_venc { get; set; }
        public string vt_tipo_venta { get; set; }
        public string vt_Observacion { get; set; }
        public int IdPeriodo { get; set; }
        public int vt_anio { get; set; }
        public int vt_mes { get; set; }
        public string Estado { get; set; }
        public int IdCaja { get; set; }
        public string IdUsuario { get; set; }
        public Nullable<System.DateTime> Fecha_Transaccion { get; set; }
        public string IdUsuarioUltModi { get; set; }
        public Nullable<System.DateTime> Fecha_UltMod { get; set; }
        public string IdUsuarioUltAnu { get; set; }
        public Nullable<System.DateTime> Fecha_UltAnu { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<int> IdPuntoVta { get; set; }
        public Nullable<bool> esta_impresa { get; set; }
        public Nullable<System.DateTime> fecha_primera_cuota { get; set; }
        public Nullable<double> valor_abono { get; set; }
    }
}
