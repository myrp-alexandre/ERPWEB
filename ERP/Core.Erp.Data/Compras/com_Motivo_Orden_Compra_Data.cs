using Core.Erp.Info.Compras;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Compras
{
    public class com_Motivo_Orden_Compra_Data
    {
        public List<com_Motivo_Orden_Compra_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<com_Motivo_Orden_Compra_Info> Lista;
                using (Entities_compras Context = new Entities_compras())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.com_Motivo_Orden_Compra
                                 where q.IdEmpresa == IdEmpresa
                                 select new com_Motivo_Orden_Compra_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdMotivo = q.IdMotivo,
                                     Cod_Motivo = q.Cod_Motivo,
                                     Descripcion = q.Descripcion,
                                     estado = q.estado,

                                     EstadoBool = q.estado == "A" ? true : false
                                 }).ToList();
                    else
                        Lista = (from q in Context.com_Motivo_Orden_Compra
                                 where q.IdEmpresa == IdEmpresa
                                 && q.estado == "A"
                                 select new com_Motivo_Orden_Compra_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdMotivo = q.IdMotivo,
                                     Cod_Motivo = q.Cod_Motivo,
                                     Descripcion = q.Descripcion,
                                     estado = q.estado,

                                     EstadoBool = q.estado == "A" ? true : false
                                 }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public com_Motivo_Orden_Compra_Info get_info(int IdEmpresa, int IdMotivo)
        {
            try
            {
                com_Motivo_Orden_Compra_Info info = new com_Motivo_Orden_Compra_Info();
                using (Entities_compras Context = new Entities_compras())
                {
                    com_Motivo_Orden_Compra Entity = Context.com_Motivo_Orden_Compra.Where(q => q.IdEmpresa == IdEmpresa && q.IdMotivo == IdMotivo).FirstOrDefault();
                    if (Entity == null) return null;

                    info = new com_Motivo_Orden_Compra_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdMotivo = Entity.IdMotivo,
                        Cod_Motivo = Entity.Cod_Motivo,
                        Descripcion = Entity.Descripcion,
                        estado = Entity.estado
                    };
                }
                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        private int get_id(int IdEmpresa)
        {
            try
            {
                int Id = 1;
                using (Entities_compras Context = new Entities_compras())
                {
                    var lst = from q in Context.com_Motivo_Orden_Compra
                              where q.IdEmpresa == IdEmpresa
                              select q;
                    if (lst.Count() > 0)
                        Id = lst.Max(q => q.IdMotivo) +  1;
                }
                return Id;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(com_Motivo_Orden_Compra_Info info)
        {
            try
            {
                using (Entities_compras Context =  new Entities_compras())
                {
                    com_Motivo_Orden_Compra Entity = new com_Motivo_Orden_Compra

                    {

                        IdEmpresa = info.IdEmpresa,
                        IdMotivo = info.IdMotivo=get_id(info.IdEmpresa),
                        Cod_Motivo = info.Cod_Motivo,
                        Descripcion = info.Descripcion,
                        estado = "A",
                        Fecha_Transac = DateTime.Now
                    };
                    Context.com_Motivo_Orden_Compra.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(com_Motivo_Orden_Compra_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_Motivo_Orden_Compra Entity = Context.com_Motivo_Orden_Compra.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdMotivo == info.IdMotivo).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.Cod_Motivo = info.Cod_Motivo;
                    Entity.Descripcion = info.Descripcion;
                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(com_Motivo_Orden_Compra_Info info)
        {
            try
            {
                using (Entities_compras Context = new Entities_compras())
                {
                    com_Motivo_Orden_Compra Entity = Context.com_Motivo_Orden_Compra.Where(q => q.IdEmpresa == info.IdEmpresa && q.IdMotivo == info.IdMotivo).FirstOrDefault();
                    if (Entity == null) return false;

                    Entity.estado = "I";
                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.FechaHoraAnul = DateTime.Now;
                    Context.SaveChanges();
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
