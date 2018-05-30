using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Producto_Composicion_Data
    {
        public List<in_Producto_Composicion_Info> get_list(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                List<in_Producto_Composicion_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.in_Producto_Composicion
                             where q.IdEmpresa == IdEmpresa
                             && q.IdProductoPadre == IdProducto
                             select new in_Producto_Composicion_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdProductoPadre = q.IdProductoPadre,
                                 IdProductoHijo = q.IdProductoHijo,
                                 IdUnidadMedida = q.IdUnidadMedida,
                                 Cantidad = q.Cantidad,
                             }).ToList();

                    int secuencia = 0;
                    Lista.ForEach(q => q.secuencia = secuencia++);
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(List<in_Producto_Composicion_Info> Lista)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    foreach (var item in Lista)
                    {
                        in_Producto_Composicion Entity = new in_Producto_Composicion
                        {
                            IdEmpresa = item.IdEmpresa,
                            IdProductoPadre = item.IdProductoPadre,
                            IdProductoHijo = item.IdProductoHijo,
                            IdUnidadMedida = item.IdUnidadMedida,
                            Cantidad = item.Cantidad,
                        };
                        Context.in_Producto_Composicion.Add(Entity);
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
                    Context.Database.ExecuteSqlCommand("DELETE in_Producto_Composicion WHERE IdEmpresa = "+IdEmpresa+ " AND IdProductoPadre = "+IdProducto);
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
