using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.CuentasPorCobrar
{
   public class CXC_006_sin_comision_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdLiquidacion { get; set; }
        public System.DateTime Fecha { get; set; }
        public string Observacion { get; set; }
        public Nullable<int> IdVendedor { get; set; }
        public bool Estado { get; set; }
        public string Ve_Vendedor { get; set; }
        public string vt_tipoDoc { get; set; }
        public string vt_NumFactura { get; set; }
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
        public string pe_nombreCompleto { get; set; }
        public double Saldo { get; set; }
    }
}
