using Core.Erp.Info.General;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.General
{
    public class tb_sucursal_Data
    {
        public List<tb_sucursal_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<tb_sucursal_Info> Lista;

                using (Entities_general Context = new Entities_general())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.tb_sucursal
                             where q.IdEmpresa == IdEmpresa                             
                             select new tb_sucursal_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdSucursal = q.IdSucursal,
                                 Su_Descripcion = q.Su_Descripcion,
                                 Su_CodigoEstablecimiento = q.Su_CodigoEstablecimiento,
                                 Su_Ruc = q.Su_Ruc,
                                 Estado = q.Estado,

                                 EstadoBool = q.Estado == "A" ? true : false
                             }).ToList();
                    else
                        Lista = (from q in Context.tb_sucursal
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new tb_sucursal_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdSucursal = q.IdSucursal,
                                     Su_Descripcion = q.Su_Descripcion,
                                     Su_CodigoEstablecimiento = q.Su_CodigoEstablecimiento,
                                     Su_Ruc = q.Su_Ruc,
                                     Estado = q.Estado,

                                     EstadoBool = q.Estado == "A" ? true : false
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public tb_sucursal_Info get_info(int IdEmpresa, int IdSucursal)
        {
            try
            {
                tb_sucursal_Info info = new tb_sucursal_Info();

                using (Entities_general Context = new Entities_general())
                {
                    tb_sucursal Entity = Context.tb_sucursal.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdSucursal == IdSucursal);
                    if (Entity == null) return null;

                    info = new tb_sucursal_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdSucursal = Entity.IdSucursal,
                        codigo = Entity.codigo,
                        Su_Descripcion = Entity.Su_Descripcion,
                        Su_CodigoEstablecimiento = Entity.Su_CodigoEstablecimiento,
                        Su_Ubicacion = Entity.Su_Ubicacion,
                        Su_Ruc = Entity.Su_Ruc,
                        Su_JefeSucursal = Entity.Su_JefeSucursal,
                        Su_Telefonos = Entity.Su_Telefonos,
                        Su_Direccion = Entity.Su_Direccion,
                        Es_establecimiento = Entity.Es_establecimiento == null ? false : Convert.ToBoolean(Entity.Es_establecimiento),
                        Estado = Entity.Estado,
                    };
                }

                return info;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public int get_id(int IdEmpresa)
        {
            try
            {
                int ID = 1;

                using (Entities_general Context = new Entities_general())
                {
                    var lst = from q in Context.tb_sucursal
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdSucursal) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(tb_sucursal_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_sucursal Entity = new tb_sucursal
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdSucursal = info.IdSucursal = get_id(info.IdEmpresa),
                        codigo = info.codigo,
                        Su_Descripcion = info.Su_Descripcion,
                        Su_CodigoEstablecimiento = info.Su_CodigoEstablecimiento,
                        Su_Ubicacion = info.Su_Ubicacion,
                        Su_Ruc = info.Su_Ruc,
                        Su_JefeSucursal = info.Su_JefeSucursal,
                        Su_Telefonos = info.Su_Telefonos,
                        Su_Direccion = info.Su_Direccion,
                        Es_establecimiento = info.Es_establecimiento,
                        Estado = info.Estado = "A",

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = info.Fecha_Transac = DateTime.Now
                    };
                    Context.tb_sucursal.Add(Entity);
                    Context.SaveChanges();
                }
                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool modificarDB(tb_sucursal_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_sucursal Entity = Context.tb_sucursal.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal);
                    if (Entity == null)
                        return false;
                    Entity.codigo = info.codigo;
                    Entity.Su_Descripcion = info.Su_Descripcion;
                    Entity.Su_CodigoEstablecimiento = info.Su_CodigoEstablecimiento;
                    Entity.Su_Ubicacion = info.Su_Ubicacion;
                    Entity.Su_Ruc = info.Su_Ruc;
                    Entity.Su_JefeSucursal = info.Su_JefeSucursal;
                    Entity.Su_Telefonos = info.Su_Telefonos;
                    Entity.Su_Direccion = info.Su_Direccion;
                    Entity.Es_establecimiento = info.Es_establecimiento;

                    Entity.IdUsuarioUltMod = info.IdUsuarioUltMod;
                    Entity.Fecha_UltMod = info.Fecha_UltMod = DateTime.Now;
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool anularDB(tb_sucursal_Info info)
        {
            try
            {
                using (Entities_general Context = new Entities_general())
                {
                    tb_sucursal Entity = Context.tb_sucursal.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdSucursal == info.IdSucursal);
                    if (Entity == null)
                        return false;
                    Entity.Estado = info.Estado = "I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = info.Fecha_UltAnu = DateTime.Now;
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
