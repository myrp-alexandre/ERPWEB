using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Producto_x_fa_NivelDescuento_Data
    {
        public List<in_Producto_x_fa_NivelDescuento_Info> get_list(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                List<in_Producto_x_fa_NivelDescuento_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.in_Producto_x_fa_NivelDescuento
                             where q.IdEmpresa == IdEmpresa
                             && q.IdProducto == IdProducto
                             select new in_Producto_x_fa_NivelDescuento_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdProducto = q.IdProducto,
                                 Secuencia = q.Secuencia,
                                 IdNivel = q.IdNivel,
                                 Porcentaje = q.Porcentaje

                             }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(List<in_Producto_x_fa_NivelDescuento_Info> Lista)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    foreach (var item in Lista)
                    {
                        in_Producto_x_fa_NivelDescuento Entity = new in_Producto_x_fa_NivelDescuento
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdProducto = item.IdProducto,
                            IdNivel = item.IdNivel,
                            Secuencia = item.Secuencia,
                            Porcentaje = item.Porcentaje,
                        };
                        Context.in_Producto_x_fa_NivelDescuento.Add(Entity);
                    }
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool eliminarDB(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Context.Database.ExecuteSqlCommand("DELETE in_Producto_x_fa_NivelDescuento WHERE IdEmpresa = " + IdEmpresa + " AND IdProducto = " + IdProducto);
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}
