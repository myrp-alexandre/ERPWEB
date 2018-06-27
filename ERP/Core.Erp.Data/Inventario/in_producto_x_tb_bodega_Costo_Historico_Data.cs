using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Core.Erp.Info.Inventario;
namespace Core.Erp.Data.Inventario
{
   public class in_producto_x_tb_bodega_Costo_Historico_Data
    {

        public double get_ultimo_costo(int IdEmpresa, int IdSucursal, int IdBodega, decimal IdProducto, DateTime Fecha)
        {
           
                double costo = 0;
                int IdFechaMax = 0;
                int SecuenciaMax = 0;
                Fecha = Fecha.Date;

                using (Entities_inventario Contex = new Entities_inventario())
                {

                    try
                    {
                         IdFechaMax = (from q in Contex.in_producto_x_tb_bodega_Costo_Historico
                                          where q.IdEmpresa == IdEmpresa
                                          && q.IdSucursal == IdSucursal
                                          && q.IdBodega == IdBodega
                                          && q.IdProducto == IdProducto
                                          && q.fecha <= Fecha
                                          select q).Max(v => v.IdFecha);
                    }
                    catch (Exception)
                    {

                    }

                    try
                    {
                         SecuenciaMax = (from q in Contex.in_producto_x_tb_bodega_Costo_Historico
                                            where q.IdEmpresa == IdEmpresa
                                            && q.IdSucursal == IdSucursal
                                            && q.IdBodega == IdBodega
                                            && q.IdProducto == IdProducto
                                            && q.IdFecha == IdFechaMax
                                            select q).Max(v => v.Secuencia);
                    }
                    catch (Exception)
                    {

                    }


                    try
                    {
                        costo = (from q in Contex.in_producto_x_tb_bodega_Costo_Historico
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdSucursal == IdSucursal
                                 && q.IdBodega == IdBodega && q.IdProducto == IdProducto
                                 && q.IdFecha == IdFechaMax && q.Secuencia == SecuenciaMax
                                 select q.costo).Max();

                    }
                    catch (Exception)
                    {

                    }
                    }

                return costo;
              
           
        }

    

    }
}
