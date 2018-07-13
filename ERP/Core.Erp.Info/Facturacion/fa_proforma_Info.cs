using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Facturacion
{
    public class fa_proforma_Info
    {
        public int IdEmpresa { get; set; }
        public int IdSucursal { get; set; }
        public decimal IdProforma { get; set; }
        public decimal IdCliente { get; set; }
        public string IdTerminoPago { get; set; }
        public int pf_plazo { get; set; }
        public string pf_codigo { get; set; }
        public string pf_observacion { get; set; }
        public System.DateTime pf_fecha { get; set; }
        public System.DateTime pf_fecha_vcto { get; set; }
        public bool estado { get; set; }
        public string IdUsuario_creacion { get; set; }
        public Nullable<System.DateTime> fecha_creacion { get; set; }
        public string IdUsuario_modificacion { get; set; }
        public Nullable<System.DateTime> fecha_modificacion { get; set; }
        public string IdUsuario_anulacion { get; set; }
        public Nullable<System.DateTime> fecha_anulacion { get; set; }
        public int IdBodega { get; set; }
        public int IdVendedor { get; set; }
        public string pf_atencion_a { get; set; }
        public int pr_dias_entrega { get; set; }
    }
}
