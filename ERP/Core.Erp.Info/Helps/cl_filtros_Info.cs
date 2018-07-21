using Core.Erp.Info.Reportes.Inventario;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Info.Helps
{
    public class cl_filtros_Info
    {
        [Required(ErrorMessage = "El campo fecha inicio es obligatorio")]
        [DataType(DataType.Date, ErrorMessage = "El campo fecha inicio debe ser una fecha en formato dd/MM/yyyy")]
        public DateTime fecha_ini { get; set; }
        [Required(ErrorMessage = "El campo fecha fin es obligatorio")]
        [DataType(DataType.Date, ErrorMessage = "El campo fecha fin debe ser una fecha en formato dd/MM/yyyy")]
        public DateTime fecha_fin { get; set; }
        public bool mostrar_registros_0 { get; set; }

        #region Filtros inventario
        public int IdSucursal { get; set; }
        public int IdBodega { get; set; }
        public string IdCategoria { get; set; }
        public int IdLinea { get; set; }
        public int IdGrupo { get; set; }
        public int IdSubGrupo { get; set; }
        public decimal? IdProducto { get; set; }
        public int IdMovi_inven_tipo { get; set; }
        public string signo { get; set; }
        public bool no_mostrar_valores_en_0 { get; set; }
        public bool mostrar_saldos_en_0 { get; set; }
        public bool mostrar_detallado { get; set; }

        #endregion

        #region Filtros activo
        public int IdActivoFijoTipo { get; set; }
        public int IdCategoriaAF { get; set; }
        public string Estado_Proceso { get; set; }
        public string IdUsuario { get; set; }
        public DateTime fecha { get; set; }
        #endregion

        #region Filtros cuentas por pagar
        public decimal IdProveedor { get; set; }
        public bool mostrar_agrupado { get; set; }
        public bool no_mostrar_en_conciliacion { get; set; }
        public bool no_mostrar_saldo_en_0 { get; set; }
        
        #endregion
        public List<INV_008_Info> lst_decimal { get; set; }

        public int IdTipoNomina { get; set; }
        public int IdNomina { get; set; }
        public string IdCtaCble { get; set; }

        public cl_filtros_Info()
        {
            fecha_ini = DateTime.Now.Date.AddMonths(-1);
            fecha_fin = DateTime.Now.Date;
        }
    }

    public class cl_filtros_facturacion_Info
    {
        public DateTime fecha_fin { get; set; }
        public decimal? IdProducto { get; set; }
        public decimal? IdCliente { get; set; }
        public int? IdClienteContacto { get; set; }
        public int? IdVendedor { get; set; }
        public decimal? IdProductoPadre { get; set; }
        public bool mostrar_anulados { get; set; }
        public decimal? IdEntidad { get; set; }
        public DateTime fecha_ini { get; set; }
        public int IdSucursal { get; set; }
    }
}
