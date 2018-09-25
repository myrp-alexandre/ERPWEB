using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.CuentasPorCobrar
{
    public class cxc_liquidacion_comisiones_det_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        public int Secuencia { get; set; }
        public int IdVendedor { get; set; }
        public int fa_IdEmpresa { get; set; }
        public int fa_IdSucursal { get; set; }
        public int fa_IdBodega { get; set; }
        public decimal fa_IdCbteVta { get; set; }
        public double SubtotalFactura { get; set; }
        public double IvaFactura { get; set; }
        public double TotalFactura { get; set; }
        public double TotalCobrado { get; set; }
        public double BaseComision { get; set; }
        public double PorcentajeComision { get; set; }
        public double TotalAComisionar { get; set; }
        public double TotalComisionado { get; set; }
        public double TotalLiquidacion { get; set; }
        public bool NoComisiona { get; set; }

        public string vt_NumFactura { get; set; }
        public string Nombres { get; set; }
        public DateTime vt_fecha { get; set; }
        public DateTime vt_fecha_venc { get; set; }
    }
}
