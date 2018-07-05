using Core.Erp.Info.Inventario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Erp.Data.Inventario
{
    public class in_Producto_Data
    {
        public List<in_Producto_Info> get_list(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<in_Producto_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    if(mostrar_anulados)
                    Lista = (from q in Context.in_Producto
                             where q.IdEmpresa == IdEmpresa
                             select new in_Producto_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdProducto = q.IdProducto,
                                 pr_codigo = q.pr_codigo,
                                 pr_descripcion = q.pr_descripcion,
                                 Estado = q.Estado,
                                 lote_fecha_vcto = q.lote_fecha_vcto
                             }).ToList();
                    else
                        Lista = (from q in Context.in_Producto
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 select new in_Producto_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProducto = q.IdProducto,
                                     pr_codigo = q.pr_codigo,
                                     pr_descripcion = q.pr_descripcion,
                                     Estado = q.Estado,
                                     lote_fecha_vcto = q.lote_fecha_vcto
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }
        public List<in_Producto_Info> get_list_para_composicion(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<in_Producto_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.in_Producto
                                 join t in Context.in_ProductoTipo
                                 on new { q.IdEmpresa, q.IdProductoTipo} equals new { t.IdEmpresa,t.IdProductoTipo}
                                 where q.IdEmpresa == IdEmpresa
                                 && t.tp_ManejaInven == "S"
                                 select new in_Producto_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProducto = q.IdProducto,
                                     pr_codigo = q.pr_codigo,
                                     pr_descripcion = q.pr_descripcion,
                                     Estado = q.Estado,
                                     lote_fecha_vcto = q.lote_fecha_vcto
                                 }).ToList();
                    else
                        Lista = (from q in Context.in_Producto
                                 join t in Context.in_ProductoTipo
                                 on new { q.IdEmpresa, q.IdProductoTipo } equals new { t.IdEmpresa, t.IdProductoTipo }
                                 where q.IdEmpresa == IdEmpresa
                                 && q.Estado == "A"
                                 && t.tp_ManejaInven == "S"
                                 select new in_Producto_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProducto = q.IdProducto,
                                     pr_codigo = q.pr_codigo,
                                     pr_descripcion = q.pr_descripcion,
                                     Estado = q.Estado,
                                     lote_fecha_vcto = q.lote_fecha_vcto
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_padres(int IdEmpresa, bool mostrar_anulados)
        {
            try
            {
                List<in_Producto_Info> Lista;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    if (mostrar_anulados)
                        Lista = (from q in Context.in_Producto
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdProducto_padre == null
                                 select new in_Producto_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProducto = q.IdProducto,
                                     pr_codigo = q.pr_codigo,
                                     pr_descripcion = q.pr_descripcion,
                                     Estado = q.Estado,
                                     lote_fecha_vcto = q.lote_fecha_vcto
                                 }).ToList();
                    else
                        Lista = (from q in Context.in_Producto
                                 where q.IdEmpresa == IdEmpresa
                                 && q.IdProducto_padre == null
                                 && q.Estado == "A"
                                 select new in_Producto_Info
                                 {
                                     IdEmpresa = q.IdEmpresa,
                                     IdProducto = q.IdProducto,
                                     pr_codigo = q.pr_codigo,
                                     pr_descripcion = q.pr_descripcion,
                                     Estado = q.Estado,
                                     lote_fecha_vcto = q.lote_fecha_vcto
                                 }).ToList();
                }

                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_combo_padre(int IdEmpresa)
        {
            try
            {
                List<in_Producto_Info> Lista;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_producto_padre_combo
                             where q.IdEmpresa == IdEmpresa
                             select new in_Producto_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdProducto = q.IdProducto,
                                 pr_descripcion = q.pr_descripcion,
                                 nom_presentacion = q.nom_presentacion,
                                 nom_categoria = q.ca_Categoria                                 
                             }).ToList();
                }
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public List<in_Producto_Info> get_list_combo_hijo(int IdEmpresa, decimal IdProducto_padre)
        {
            try
            {
                List<in_Producto_Info> Lista;
                using (Entities_inventario Context = new Entities_inventario())
                {
                    Lista = (from q in Context.vwin_producto_hijo_combo
                             where q.IdEmpresa == IdEmpresa
                             && q.IdProducto_padre == IdProducto_padre
                             select new in_Producto_Info
                             {
                                 IdEmpresa = q.IdEmpresa,
                                 IdProducto = q.IdProducto,
                                 pr_descripcion = q.pr_descripcion,
                                 nom_presentacion = q.nom_presentacion,
                                 nom_categoria = q.ca_Categoria,
                                 lote_fecha_vcto = q.lote_fecha_vcto,
                                 lote_num_lote = q.lote_num_lote,
                                 IdProducto_padre = q.IdProducto_padre,
                                 IdUnidadMedida =   q.IdUnidadMedida

                             }).ToList();
                }
                Lista.ForEach(V=>{
                    V.pr_descripcion = V.pr_descripcion + " " + V.lote_num_lote + " ";
                    if(V.lote_fecha_vcto!=null)
                    {
                        V.pr_descripcion = V.pr_descripcion + V.lote_fecha_vcto.ToString().Substring(0, 10);
                    };
                });
                return Lista;
            }
            catch (Exception)
            {

                throw;
            }
        }


        public in_Producto_Info get_info(int IdEmpresa, decimal IdProducto)
        {
            try
            {
                in_Producto_Info info = new in_Producto_Info();

                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Producto Entity = Context.in_Producto.FirstOrDefault(q => q.IdEmpresa == IdEmpresa && q.IdProducto == IdProducto);
                    if (Entity == null) return null;
                    info = new in_Producto_Info
                    {
                        IdEmpresa = Entity.IdEmpresa,
                        IdProducto = Entity.IdProducto,
                        pr_codigo = Entity.pr_codigo,
                        pr_codigo2 = Entity.pr_codigo2,
                        pr_descripcion = Entity.pr_descripcion,
                        pr_descripcion_2 = Entity.pr_descripcion_2,
                        IdProductoTipo = Entity.IdProductoTipo,
                        IdMarca = Entity.IdMarca,
                        IdPresentacion = Entity.IdPresentacion,
                        IdCategoria = Entity.IdCategoria,
                        IdLinea = Entity.IdLinea,
                        IdGrupo = Entity.IdGrupo,
                        IdSubGrupo = Entity.IdSubGrupo,
                        IdUnidadMedida = Entity.IdUnidadMedida,
                        IdUnidadMedida_Consumo = Entity.IdUnidadMedida_Consumo,
                        pr_codigo_barra = Entity.pr_codigo_barra,
                        pr_observacion = Entity.pr_observacion,
                        Estado = Entity.Estado,
                        IdCod_Impuesto_Iva = Entity.IdCod_Impuesto_Iva,
                        Aparece_modu_Ventas = Entity.Aparece_modu_Ventas,
                        Aparece_modu_Compras = Entity.Aparece_modu_Compras,
                        Aparece_modu_Inventario = Entity.Aparece_modu_Inventario,
                        Aparece_modu_Activo_F = Entity.Aparece_modu_Activo_F,
                        IdProducto_padre = Entity.IdProducto_padre,
                        lote_fecha_fab = Entity.lote_fecha_fab,
                        lote_fecha_vcto = Entity.lote_fecha_vcto,
                        lote_num_lote = Entity.lote_num_lote,
                        precio_1 = Entity.precio_1 == null ? 0 : Convert.ToDouble(Entity.precio_1),
                        precio_2 = Entity.precio_2 == null ? 0 : Convert.ToDouble(Entity.precio_2),
                        signo_2 = Entity.signo_2,
                        porcentaje_2 = Entity.porcentaje_2 == null ? 0 : Convert.ToDouble(Entity.porcentaje_2),
                        precio_3 = Entity.precio_3 == null ? 0 : Convert.ToDouble(Entity.precio_3),
                        signo_3 = Entity.signo_3,
                        porcentaje_3 = Entity.porcentaje_3 == null ? 0 : Convert.ToDouble(Entity.porcentaje_3),
                        precio_4 = Entity.precio_4 == null ? 0 : Convert.ToDouble(Entity.precio_4),
                        signo_4 = Entity.signo_4,
                        porcentaje_4 = Entity.porcentaje_4 == null ? 0 : Convert.ToDouble(Entity.porcentaje_4),
                        precio_5 = Entity.precio_5 == null ? 0 : Convert.ToDouble(Entity.precio_5),
                        signo_5 = Entity.signo_5,
                        porcentaje_5 = Entity.porcentaje_5 == null ? 0 : Convert.ToDouble(Entity.porcentaje_5),
                        se_distribuye = Entity.se_distribuye == null ? false : Convert.ToBoolean(Entity.se_distribuye)
                    };
                }

                return info;
            }
            catch (Exception)
            {
                throw;
            }
        }

        private decimal get_id(int IdEmpresa)
        {
            try
            {
                decimal ID = 1;

                using (Entities_inventario Context = new Entities_inventario())
                {
                    var lst = from q in Context.in_Producto
                              where q.IdEmpresa == IdEmpresa
                              select q;

                    if (lst.Count() > 0)
                        ID = lst.Max(q => q.IdProducto) + 1;
                }

                return ID;
            }
            catch (Exception)
            {

                throw;
            }
        }

        public bool guardarDB(in_Producto_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Producto Entity = new in_Producto
                    {
                        IdEmpresa = info.IdEmpresa,
                        IdProducto = info.IdProducto = get_id(info.IdEmpresa),
                        pr_codigo = info.pr_codigo,
                        pr_codigo2 = info.pr_codigo2,
                        pr_descripcion = info.pr_descripcion,
                        pr_descripcion_2 = info.pr_descripcion_2,
                        IdProductoTipo = info.IdProductoTipo,
                        IdMarca = info.IdMarca,
                        IdPresentacion = info.IdPresentacion,
                        IdCategoria = info.IdCategoria,
                        IdLinea = info.IdLinea,
                        IdGrupo = info.IdGrupo,
                        IdSubGrupo = info.IdSubGrupo,
                        IdUnidadMedida = info.IdUnidadMedida,
                        IdUnidadMedida_Consumo = info.IdUnidadMedida_Consumo,
                        pr_codigo_barra = info.pr_codigo_barra,
                        pr_observacion = info.pr_observacion,
                        Estado = info.Estado = "A",
                        IdCod_Impuesto_Iva = info.IdCod_Impuesto_Iva,
                        Aparece_modu_Ventas = info.Aparece_modu_Ventas,
                        Aparece_modu_Compras = info.Aparece_modu_Compras,
                        Aparece_modu_Inventario = info.Aparece_modu_Inventario,
                        Aparece_modu_Activo_F = info.Aparece_modu_Activo_F,
                        IdProducto_padre = info.IdProducto_padre,
                        lote_fecha_fab = info.lote_fecha_fab,
                        lote_fecha_vcto = info.lote_fecha_vcto,
                        lote_num_lote = info.lote_num_lote,
                        precio_1 = info.precio_1,
                        precio_2 = info.precio_2,
                        signo_2 = info.signo_2,
                        porcentaje_2 = info.porcentaje_2,
                        precio_3 = info.precio_3,
                        signo_3 = info.signo_3,
                        porcentaje_3 = info.porcentaje_3,
                        precio_4 = info.precio_4,
                        signo_4 = info.signo_4,
                        porcentaje_4 = info.porcentaje_4,
                        precio_5 = info.precio_5,
                        signo_5 = info.signo_5,
                        porcentaje_5 = info.porcentaje_5,
                        se_distribuye = info.se_distribuye,

                        IdUsuario = info.IdUsuario,
                        Fecha_Transac = DateTime.Now
                    };
                    Context.in_Producto.Add(Entity);
                    Context.SaveChanges();
                }

                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        public bool modificarDB(in_Producto_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Producto Entity = Context.in_Producto.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdProducto == info.IdProducto);
                    if (Entity == null) return false;
                    Entity.pr_codigo = info.pr_codigo;
                    Entity.pr_codigo2 = info.pr_codigo2;
                    Entity.pr_descripcion = info.pr_descripcion;
                    Entity.pr_descripcion_2 = info.pr_descripcion_2;
                    Entity.IdProductoTipo = info.IdProductoTipo;
                    Entity.IdMarca = info.IdMarca;
                    Entity.IdPresentacion = info.IdPresentacion;
                    Entity.IdCategoria = info.IdCategoria;
                    Entity.IdLinea = info.IdLinea;
                    Entity.IdGrupo = info.IdGrupo;
                    Entity.IdSubGrupo = info.IdSubGrupo;
                    Entity.IdUnidadMedida = info.IdUnidadMedida;
                    Entity.IdUnidadMedida_Consumo = info.IdUnidadMedida_Consumo;
                    Entity.pr_codigo_barra = info.pr_codigo_barra;
                    Entity.pr_observacion = info.pr_observacion;
                    Entity.IdCod_Impuesto_Iva = info.IdCod_Impuesto_Iva;
                    Entity.Aparece_modu_Ventas = info.Aparece_modu_Ventas;
                    Entity.Aparece_modu_Compras = info.Aparece_modu_Compras;
                    Entity.Aparece_modu_Inventario = info.Aparece_modu_Inventario;
                    Entity.Aparece_modu_Activo_F = info.Aparece_modu_Activo_F;
                    Entity.IdProducto_padre = info.IdProducto_padre;
                    Entity.lote_fecha_fab = info.lote_fecha_fab;
                    Entity.lote_fecha_vcto = info.lote_fecha_vcto;
                    Entity.lote_num_lote = info.lote_num_lote;
                    Entity.precio_1 = info.precio_1;
                    Entity.precio_2 = info.precio_2;
                    Entity.signo_2 = info.signo_2;
                    Entity.porcentaje_2 = info.porcentaje_2;
                    Entity.precio_3 = info.precio_3;
                    Entity.signo_3 = info.signo_3;
                    Entity.porcentaje_3 = info.porcentaje_3;
                    Entity.precio_4 = info.precio_4;
                    Entity.signo_4 = info.signo_4;
                    Entity.porcentaje_4 = info.porcentaje_4;
                    Entity.precio_5 = info.precio_5;
                    Entity.signo_5 = info.signo_5;
                    Entity.porcentaje_5 = info.porcentaje_5;
                    Entity.se_distribuye = info.se_distribuye;

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

        public bool anularDB(in_Producto_Info info)
        {
            try
            {
                using (Entities_inventario Context = new Entities_inventario())
                {
                    in_Producto Entity = Context.in_Producto.FirstOrDefault(q => q.IdEmpresa == info.IdEmpresa && q.IdProducto == info.IdProducto);
                    if (Entity == null) return false;
                    Entity.Estado = "I";

                    Entity.IdUsuarioUltAnu = info.IdUsuarioUltAnu;
                    Entity.Fecha_UltAnu = DateTime.Now;
                    Entity.pr_motivoAnulacion = info.pr_motivoAnulacion;

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
