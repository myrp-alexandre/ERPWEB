using Core.Erp.Info.Reportes.Facturacion;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Reportes.Facturacion
{
    public class FAC_001_Data
    {
         public List<FAC_001_Info> get_list(int IdEmpresa, int IdSucursal, int IdVendedor, decimal IdCliente, int IdCliente_contacto, decimal IdProducto, decimal IdProducto_padre, DateTime fecha_ini, DateTime fecha_fin, bool mostrar_anulados)
        {
            try
            {

                fecha_fin = Convert.ToDateTime(fecha_fin.Date.ToShortDateString());
                fecha_ini = Convert.ToDateTime(fecha_ini.Date.ToShortDateString());

                int IdSucursal_Ini = IdSucursal;
                int IdSucursal_Fin = IdSucursal == 0 ? 99999 : IdSucursal;

                int IdVendedor_Ini = IdVendedor;
                int IdVendedor_Fin = IdVendedor == 0 ? 99999 : IdVendedor;

                decimal IdCliente_Ini = IdCliente;
                decimal IdCliente_Fin = IdCliente == 0 ? 999999 : IdCliente;

                int IdCliente_contacto_Ini = IdCliente_contacto;
                int IdCliente_contacto_Fin = IdCliente_contacto == 0 ? 9999 : IdCliente_contacto;

                decimal IdProducto_Ini = IdProducto;
                decimal IdProducto_Fin = IdProducto == 0 ? 99999 : IdProducto;

                decimal IdProducto_padre_Ini = IdProducto_padre;
                decimal IdProducto_padre_Fin = IdProducto_padre == 0 ? 999999 : IdProducto_padre;

                fecha_ini = fecha_ini.Date;
                fecha_fin = fecha_fin.Date;

                List<FAC_001_Info> Lista;
                using (Entities_reportes Context = new Entities_reportes())
                {
                    Lista = (from q in Context.VWFAC_001
                             where q.IdEmpresa ==IdEmpresa
                             && q.IdSucursal >=IdSucursal_Ini  && q.IdSucursal <= IdSucursal_Fin
                             &&  q.IdVendedor>= IdVendedor_Ini && q.IdVendedor <= IdVendedor_Fin
                             &&   q.IdCliente>= IdCliente_Ini && q.IdCliente <= IdCliente_Fin
                             && q.IdContacto>= IdCliente_contacto_Ini && q.IdContacto <= IdCliente_contacto_Fin
                             &&  q.IdProducto >= IdProducto_Ini && q.IdProducto <= IdProducto_Fin
                             &&  q.IdProducto_padre>= IdProducto_padre_Ini && q.IdProducto_padre <= IdProducto_padre_Fin
                             && q.vt_fecha >= fecha_ini && q.vt_fecha <= fecha_fin
                             select new FAC_001_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                                 IdCbteVta = q.IdCbteVta,
                                 Secuencia = q.Secuencia,
                                 IdProducto = q.IdProducto,
                                 IdProducto_padre = q.IdProducto_padre,
                                 vt_NumFactura = q.vt_NumFactura,
                                 IdCliente = q.IdCliente,
                                 IdContacto = q.IdContacto,
                                 NombreContacto = q.NombreContacto,
                                 IdVendedor = q.IdVendedor,
                                 Ve_Vendedor = q.Ve_Vendedor,
                                 NombreCliente = q.NombreCliente,
                                 pr_descripcion = q.pr_descripcion,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 vt_cantidad = q.vt_cantidad,
                                 vt_DesctTotal = q.vt_DesctTotal,
                                 vt_iva = q.vt_iva,
                                 vt_PorDescUnitario = q.vt_PorDescUnitario,
                                 vt_Precio = q.vt_Precio,
                                 vt_PrecioFinal = q.vt_PrecioFinal,
                                 vt_Subtotal = q.vt_Subtotal,
                                 vt_total = q.vt_total, 
                                 Estado = q.Estado,
                                 Su_Descripcion = q.Su_Descripcion,
                                 vt_fecha = q.vt_fecha
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
