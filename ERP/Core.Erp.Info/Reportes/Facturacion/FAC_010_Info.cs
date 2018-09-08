using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Reportes.Facturacion
{
  public class FAC_010_Info
    {
        public int IdEmpresa { get; set; }
        public decimal IdProducto { get; set; }
        public int IdProductoTipo { get; set; }
        public int IdMarca { get; set; }
        public string IdCategoria { get; set; }
        public int IdLinea { get; set; }
        public int IdGrupo { get; set; }
        public int IdSubGrupo { get; set; }
        public string IdPresentacion { get; set; }
        public string NomProducto { get; set; }
        public string NomPresentacion { get; set; }
        public string NomMarca { get; set; }
        public string NomTipoProducto { get; set; }
        public string NomCategoria { get; set; }
        public string NomLinea { get; set; }
        public string NomGrupo { get; set; }
        public string NomSubGrupo { get; set; }
        public double PRECIO1 { get; set; }
        public double PRECIO2 { get; set; }
        public double PRECIO3 { get; set; }
        public double PRECIO4 { get; set; }
        public double PRECIO5 { get; set; }
        public string Estado { get; set; }
    }
}
