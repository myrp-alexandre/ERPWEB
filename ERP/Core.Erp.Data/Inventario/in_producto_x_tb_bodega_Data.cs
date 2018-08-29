using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
namespace Core.Erp.Data.Inventario
{
   public class in_producto_x_tb_bodega_Data
    {

        public List<in_producto_x_tb_bodega_Info> get_lis(int IdEmpresa, decimal IdProducto)
        {
            List<in_producto_x_tb_bodega_Info> lista=null;
            int secuancia = 0;
            try
            {
                using (Entities_inventario Context=new Entities_inventario())
                {

                    lista = (from q in Context.in_producto_x_tb_bodega
                             where q.IdEmpresa == IdEmpresa
                             && q.IdProducto == IdProducto
                             select new in_producto_x_tb_bodega_Info
                             {
                                IdEmpresa=q.IdEmpresa,
                                IdSucursal=q.IdSucursal,
                                IdBodega=q.IdBodega,
                                IdProducto=q.IdProducto,
                                Stock_minimo=q.Stock_minimo
                                

                             }).ToList();
                        
                }
                lista.ForEach(v => v.Secuencia = secuancia++);
                return lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<in_producto_x_tb_bodega_Info> get_lis(int IdEmpresa)
        {
            int secuancia = 0;
            List<in_producto_x_tb_bodega_Info> lista = null;
            try
            {
                using (Entities_general Context = new Entities_general())
                {

                    lista = (from q in Context.vwtb_bodega_x_sucursal
                             where q.IdEmpresa == IdEmpresa
                             select new in_producto_x_tb_bodega_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 IdBodega = q.IdBodega,
                             }).ToList();

                }
                lista.ForEach(v => v.Secuencia = secuancia++);
                return lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
